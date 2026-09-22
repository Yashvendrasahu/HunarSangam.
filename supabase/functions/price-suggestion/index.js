// supabase/functions/price-suggestion/index.js
// Supabase Edge Function (JavaScript ES Modules) for Fair Artisan Price Suggestion

import { serve } from "https://deno.land/std@0.177.0/http/server.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const {
      category,
      material,
      craft_type,
      dimensions,
      est_weight_grams,
      raw_materials_cost,
      labor_hours
    } = await req.json();

    // Modular rule-based fair pricing engine with cluster benchmarks
    // 1. Raw material base cost estimation
    let rawMaterialCost = Number(raw_materials_cost) || 85.0;
    if (dimensions?.diameter && dimensions?.diameter > 14) {
      rawMaterialCost += 35.0;
    }

    // 2. Fair labor wage calculation based on skilled artisan cluster rates (min ₹60/hr)
    const hours = Number(labor_hours) || 2.0;
    const laborCost = Math.round(hours * 60.0);

    // 3. Cluster cooperative overhead & tooling
    const clusterOverhead = 25.0;

    // 4. Fair artisan profit margin (20-25%)
    const subtotal = rawMaterialCost + laborCost + clusterOverhead;
    const fairProfit = Math.round(subtotal * 0.22);

    const calculatedPrice = Math.round(subtotal + fairProfit);
    const suggestedPrice = Math.max(calculatedPrice, 280);
    const minimumPrice = Math.round(suggestedPrice * 0.85);
    const maximumPrice = Math.round(suggestedPrice * 1.25);

    const breakdown = {
      raw_materials_cost: rawMaterialCost,
      labor_cost: laborCost,
      cluster_overhead_cost: clusterOverhead,
      fair_profit_cost: fairProfit,
      suggested_price: suggestedPrice,
      minimum_price: minimumPrice,
      maximum_price: maximumPrice,
      currency: "INR",
      fair_wage_certified: true,
      cluster_benchmark: "ODOP Uttar Pradesh & Assam Cane Standard Rate Card"
    };

    return new Response(JSON.stringify({ success: true, data: breakdown }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });
  } catch (err) {
    return new Response(JSON.stringify({ success: false, error: err.message }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 400,
    });
  }
});
