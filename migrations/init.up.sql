CREATE TABLE IF NOT EXISTS users(
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT UNIQUE NOT NULL,
    cellphone VARCHAR(11) UNIQUE,

    created_at TIMESTAMP DEFAULT NOW()
    )

CREATE TABLE IF NOT EXISTS restaurants (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    phone VARCHAR(8) NOT NULL UNIQUE,
    admin_id SERIAL NOT NULL,

    created_at TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (admin_id) REFERENCES users(id)
    )

CREATE TABLE IF NOT EXISTS edibles (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    restaurant_id SERIAL NOT NULL,
    price INT NOT NULL,

    created_at TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
    )

CREATE TABLE IF NOT EXISTS menus (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    restaurant_id SERIAL NOT NULL,
    description TEXT,

    created_at TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
    )

CREATE TABLE IF NOT EXISTS invoices (
    id SERIAL PRIMARY KEY,
    order_date timestamp NOT NULL,
    restaurant_id SERIAL NOT NULL,
    user_id SERIAL NOT NULL,
    paying_price int NOT NULL,

    created_at TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
    )


CREATE TABLE IF NOT EXISTS menus_edibles (
    menu_id SERIAL NOT NULL,
    edible_id SERIAL NOT NULL,
    PRIMARY KEY (menu_id, edible_id),

    created_at TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (menu_id) REFERENCES menus(id),
    FOREIGN KEY (edible_id) REFERENCES edibles(id)
    )

CREATE TABLE IF NOT EXISTS invoices_edibles (
    PRIMARY KEY (invoice_id, edible_id),

    invoice_id SERIAL NOT NULL,
    edible_id SERIAL NOT NULL,
    price_per_entity INT NOT NULL,
    count INT DEFAULT 1,

    created_at TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (edible_id) REFERENCES edibles(id)


    );