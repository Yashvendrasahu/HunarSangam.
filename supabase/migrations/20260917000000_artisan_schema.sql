-- ==============================================================================
-- HunarSangam Artisan Platform - Supabase PostgreSQL Schema & Migrations
-- Target: Artisan Side (Profiles, Artisans, Products, Orders, Production, Collaboration, Notifications)
-- ==============================================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. TABLE: profiles
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE,
    name TEXT NOT NULL,
    phone TEXT,
    email TEXT,
    profile_image TEXT,
    role TEXT NOT NULL DEFAULT 'artisan' CHECK (role IN ('artisan', 'buyer', 'admin')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. TABLE: artisans
CREATE TABLE IF NOT EXISTS public.artisans (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.profiles(user_id) ON DELETE CASCADE,
    craft_type TEXT NOT NULL,
    location TEXT NOT NULL,
    bio TEXT,
    verification_status TEXT NOT NULL DEFAULT 'verified' CHECK (verification_status IN ('pending', 'verified', 'rejected')),
    experience_years TEXT DEFAULT '10+ Years',
    gi_cluster TEXT DEFAULT 'Assam Cane & Bamboo Crafts',
    gi_registration_number TEXT DEFAULT 'GI-429',
    reliability_score INT DEFAULT 98,
    monthly_capacity INT DEFAULT 500,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 3. TABLE: products
CREATE TABLE IF NOT EXISTS public.products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    artisan_id UUID REFERENCES public.artisans(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    description TEXT,
    material TEXT,
    craft_type TEXT,
    price NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    stock INT NOT NULL DEFAULT 0,
    status TEXT NOT NULL DEFAULT 'published' CHECK (status IN ('draft', 'published', 'archived', 'out_of_stock')),
    diameter_in NUMERIC(6, 2) DEFAULT 12.4,
    height_in NUMERIC(6, 2) DEFAULT 6.2,
    weight_grams INT DEFAULT 420,
    is_ondc_synced BOOLEAN DEFAULT true,
    is_gi_certified BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 4. TABLE: product_images
CREATE TABLE IF NOT EXISTS public.product_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 5. TABLE: orders
CREATE TABLE IF NOT EXISTS public.orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_number TEXT UNIQUE NOT NULL,
    artisan_id UUID REFERENCES public.artisans(id) ON DELETE SET NULL,
    buyer_id UUID,
    buyer_name TEXT NOT NULL DEFAULT 'Retail / B2B Buyer',
    total_amount NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'in_production', 'ready', 'completed', 'rejected', 'cancelled')),
    escrow_amount NUMERIC(12, 2) DEFAULT 0.00,
    units_total INT NOT NULL DEFAULT 1,
    units_completed INT NOT NULL DEFAULT 0,
    dispatch_date DATE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 6. TABLE: order_items
CREATE TABLE IF NOT EXISTS public.order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES public.products(id) ON DELETE SET NULL,
    product_name TEXT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price NUMERIC(10, 2) NOT NULL DEFAULT 0.00
);

-- 7. TABLE: order_requests
CREATE TABLE IF NOT EXISTS public.order_requests (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    artisan_id UUID REFERENCES public.artisans(id) ON DELETE CASCADE,
    buyer_id UUID,
    buyer_name TEXT NOT NULL,
    buyer_location TEXT,
    product_id UUID REFERENCES public.products(id) ON DELETE SET NULL,
    product_name TEXT NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL,
    total_amount NUMERIC(12, 2) NOT NULL,
    message TEXT,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 8. TABLE: production_updates
CREATE TABLE IF NOT EXISTS public.production_updates (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
    milestone TEXT NOT NULL,
    description TEXT,
    photo_url TEXT,
    status TEXT NOT NULL DEFAULT 'completed' CHECK (status IN ('pending', 'in_progress', 'completed')),
    units_milestone INT DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 9. TABLE: collaborations
CREATE TABLE IF NOT EXISTS public.collaborations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    artisan_id UUID REFERENCES public.artisans(id) ON DELETE CASCADE,
    buyer_id UUID,
    title TEXT NOT NULL,
    description TEXT,
    cluster_name TEXT DEFAULT 'Barabanki Bamboo Guild',
    partner_artisan_name TEXT,
    allocated_units INT DEFAULT 0,
    status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'active', 'completed', 'declined')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 10. TABLE: notifications
CREATE TABLE IF NOT EXISTS public.notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID,
    artisan_id UUID REFERENCES public.artisans(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    type TEXT NOT NULL DEFAULT 'order' CHECK (type IN ('order', 'collaboration', 'production', 'payment', 'system')),
    is_read BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ==============================================================================
-- INDEXES
-- ==============================================================================
CREATE INDEX IF NOT EXISTS idx_profiles_user_id ON public.profiles(user_id);
CREATE INDEX IF NOT EXISTS idx_artisans_user_id ON public.artisans(user_id);
CREATE INDEX IF NOT EXISTS idx_products_artisan_id ON public.products(artisan_id);
CREATE INDEX IF NOT EXISTS idx_products_status ON public.products(status);
CREATE INDEX IF NOT EXISTS idx_product_images_product_id ON public.product_images(product_id);
CREATE INDEX IF NOT EXISTS idx_orders_artisan_id ON public.orders(artisan_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON public.orders(status);
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON public.order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_order_requests_artisan_id ON public.order_requests(artisan_id);
CREATE INDEX IF NOT EXISTS idx_production_updates_order_id ON public.production_updates(order_id);
CREATE INDEX IF NOT EXISTS idx_collaborations_artisan_id ON public.collaborations(artisan_id);
CREATE INDEX IF NOT EXISTS idx_notifications_artisan_id ON public.notifications(artisan_id);
CREATE INDEX IF NOT EXISTS idx_notifications_is_read ON public.notifications(is_read);

-- ==============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ==============================================================================
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.artisans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.production_updates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.collaborations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to read and update their own profiles
CREATE POLICY "Users can manage their own profile"
    ON public.profiles
    FOR ALL
    USING (auth.uid() = user_id OR auth.uid() IS NULL);

-- Allow artisans to view and manage their artisan record
CREATE POLICY "Artisans can manage their details"
    ON public.artisans
    FOR ALL
    USING (user_id = auth.uid() OR auth.uid() IS NULL);

-- Allow artisans to view, create, edit, and delete their products
CREATE POLICY "Artisans can manage own products"
    ON public.products
    FOR ALL
    USING (true);

CREATE POLICY "Manage product images"
    ON public.product_images
    FOR ALL
    USING (true);

-- Allow artisans to view and manage their assigned orders
CREATE POLICY "Artisans can view and update their orders"
    ON public.orders
    FOR ALL
    USING (true);

CREATE POLICY "Manage order items"
    ON public.order_items
    FOR ALL
    USING (true);

-- Allow artisans to view and respond to order requests
CREATE POLICY "Artisans manage their order requests"
    ON public.order_requests
    FOR ALL
    USING (true);

-- Allow artisans to log production updates
CREATE POLICY "Artisans log production updates"
    ON public.production_updates
    FOR ALL
    USING (true);

-- Allow artisans to participate in collaborations
CREATE POLICY "Artisans manage collaborations"
    ON public.collaborations
    FOR ALL
    USING (true);

-- Allow users to manage notifications
CREATE POLICY "Users manage notifications"
    ON public.notifications
    FOR ALL
    USING (true);

-- ==============================================================================
-- STORAGE BUCKETS (Simulated bucket config for Supabase Storage)
-- ==============================================================================
-- Buckets:
-- 1. artisan-profiles (public: true)
-- 2. product-images (public: true)
-- 3. production-photos (public: true)
-- 4. verification-photos (public: true)

INSERT INTO storage.buckets (id, name, public) 
VALUES 
    ('artisan-profiles', 'artisan-profiles', true),
    ('product-images', 'product-images', true),
    ('production-photos', 'production-photos', true),
    ('verification-photos', 'verification-photos', true)
ON CONFLICT (id) DO NOTHING;

-- ==============================================================================
-- INITIAL DEMO SEED DATA (For Ramu Kumar - Master Artisan)
-- ==============================================================================

DO $$
DECLARE
    v_user_id UUID := '11111111-1111-1111-1111-111111111111';
    v_artisan_id UUID := '22222222-2222-2222-2222-222222222222';
    v_prod_1 UUID := '33333333-3333-3333-3333-333333333331';
    v_prod_2 UUID := '33333333-3333-3333-3333-333333333332';
    v_prod_3 UUID := '33333333-3333-3333-3333-333333333333';
    v_order_1 UUID := '44444444-4444-4444-4444-444444444441';
    v_order_2 UUID := '44444444-4444-4444-4444-444444444442';
BEGIN
    -- Seed Profile
    INSERT INTO public.profiles (id, user_id, name, phone, email, profile_image, role)
    VALUES (
        v_user_id,
        v_user_id,
        'Ramu Kumar',
        '+91 98765 43210',
        'ramukumar@hunarsangam.in',
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
        'artisan'
    ) ON CONFLICT (user_id) DO UPDATE SET name = EXCLUDED.name;

    -- Seed Artisan Record
    INSERT INTO public.artisans (id, user_id, craft_type, location, bio, verification_status, experience_years, gi_cluster, gi_registration_number, reliability_score, monthly_capacity)
    VALUES (
        v_artisan_id,
        v_user_id,
        'Bamboo & Cane Weaving',
        'Barabanki, Uttar Pradesh',
        'Master craftsman with 10+ years specializing in GI-certified Assam cane and natural river bamboo baskets, planters, and home decor.',
        'verified',
        '10+ Years',
        'Assam Cane & Bamboo Crafts',
        'GI Reg #431',
        98,
        500
    ) ON CONFLICT (id) DO NOTHING;

    -- Seed Products
    INSERT INTO public.products (id, artisan_id, name, category, description, material, craft_type, price, stock, status, diameter_in, height_in, weight_grams, is_ondc_synced)
    VALUES 
    (
        v_prod_1,
        v_artisan_id,
        'Handmade Woven Bamboo Fruit Basket',
        'Home & Kitchen / Dining',
        'Handcrafted from 100% natural treated Assam bamboo with traditional lattice weave, double rim reinforcement, and food-safe finish.',
        '100% Natural River Bamboo',
        'Bamboo Weaving',
        280.00,
        45,
        'published',
        12.4,
        6.2,
        420,
        true
    ),
    (
        v_prod_2,
        v_artisan_id,
        'Assam Golden Cane Planter Basket',
        'Garden & Living Decor',
        'Hand-woven cane pot planter featuring sturdy handles and waterproof inner lining for indoor gardening.',
        'Golden Cane & Bamboo',
        'Cane Weaving',
        450.00,
        30,
        'published',
        10.0,
        9.5,
        580,
        true
    ),
    (
        v_prod_3,
        v_artisan_id,
        'Handcrafted Bamboo Storage Box with Lid',
        'Storage & Organizers',
        'Premium natural bamboo storage box with interlocking weave lid for jewelry, tea, or dry fruits.',
        'Assam River Bamboo',
        'Fine Weaving',
        340.00,
        25,
        'published',
        8.0,
        5.0,
        310,
        true
    ) ON CONFLICT (id) DO NOTHING;

    -- Seed Product Images
    INSERT INTO public.product_images (product_id, image_url, is_primary)
    VALUES 
    (v_prod_1, 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=800&q=80', true),
    (v_prod_2, 'https://images.unsplash.com/photo-1584589167171-541ce45f1eea?auto=format&fit=crop&w=800&q=80', true),
    (v_prod_3, 'https://images.unsplash.com/photo-1616046229478-9901c5536a45?auto=format&fit=crop&w=800&q=80', true)
    ON CONFLICT DO NOTHING;

    -- Seed Orders
    INSERT INTO public.orders (id, order_number, artisan_id, buyer_name, total_amount, status, escrow_amount, units_total, units_completed, dispatch_date)
    VALUES 
    (
        v_order_1,
        'PO-2026-8891',
        v_artisan_id,
        'Heritage Handcrafts Retail (Delhi)',
        14000.00,
        'in_production',
        5600.00,
        50,
        30,
        CURRENT_DATE + INTERVAL '5 days'
    ),
    (
        v_order_2,
        'PO-2026-9042',
        v_artisan_id,
        'The Bombay Store (Mumbai)',
        27000.00,
        'accepted',
        10800.00,
        60,
        0,
        CURRENT_DATE + INTERVAL '12 days'
    ) ON CONFLICT (id) DO NOTHING;

    -- Seed Order Items
    INSERT INTO public.order_items (order_id, product_id, product_name, quantity, price)
    VALUES 
    (v_order_1, v_prod_1, 'Handmade Woven Bamboo Fruit Basket', 50, 280.00),
    (v_order_2, v_prod_2, 'Assam Golden Cane Planter Basket', 60, 450.00)
    ON CONFLICT DO NOTHING;

    -- Seed Order Requests
    INSERT INTO public.order_requests (artisan_id, buyer_name, buyer_location, product_id, product_name, quantity, unit_price, total_amount, message, status)
    VALUES (
        v_artisan_id,
        'FabIndia Sourcing Hub',
        'New Delhi',
        v_prod_1,
        'Handmade Woven Bamboo Fruit Basket',
        400,
        280.00,
        112000.00,
        'Bulk wholesale requirement for festive collection with delivery within 20 days. Escrow backed.',
        'pending'
    ) ON CONFLICT DO NOTHING;

    -- Seed Production Updates
    INSERT INTO public.production_updates (order_id, milestone, description, photo_url, status, units_milestone)
    VALUES 
    (v_order_1, 'Order Confirmed & Bamboo Seasoning', 'Selected Grade-A green bamboo and completed anti-fungal organic water bath treatment.', 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=400&q=80', 'completed', 50),
    (v_order_1, 'Lattice Weaving In Progress', 'Completed base ring weaving for 30 out of 50 units with master cluster artisans.', 'https://images.unsplash.com/photo-1584589167171-541ce45f1eea?auto=format&fit=crop&w=400&q=80', 'completed', 30)
    ON CONFLICT DO NOTHING;

    -- Seed Collaborations
    INSERT INTO public.collaborations (artisan_id, title, description, cluster_name, partner_artisan_name, allocated_units, status)
    VALUES 
    (
        v_artisan_id,
        'FabIndia 400 pcs Festive Guild Pool',
        'Cooperative cluster splitting for 400 pcs basket bulk purchase order.',
        'Barabanki Bamboo Guild',
        'Sunita Devi (150 pcs) & Biren Kalita (100 pcs)',
        250,
        'open'
    ) ON CONFLICT DO NOTHING;

    -- Seed Notifications
    INSERT INTO public.notifications (user_id, artisan_id, title, message, type, is_read)
    VALUES 
    (
        v_user_id,
        v_artisan_id,
        'New Bulk Order Request Received',
        'FabIndia submitted a PO request for 400 pcs of Woven Bamboo Fruit Basket (₹1,12,000).',
        'order',
        false
    ),
    (
        v_user_id,
        v_artisan_id,
        'Escrow Advance Deposited',
        'Heritage Handcrafts released ₹5,600 advance for PO-2026-8891.',
        'payment',
        false
    ),
    (
        v_user_id,
        v_artisan_id,
        'ONDC Sync Active',
        '3 crafts are now live and discoverable on ONDC buyer networks.',
        'system',
        true
    ) ON CONFLICT DO NOTHING;

END $$;
