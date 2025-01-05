--«idx_{table_name}_{column_name}»
-- В БД уже есть индекс uk_person_visits

CREATE INDEX IF NOT EXISTS idx_menu_pizzeria_id ON menu(pizzeria_id);
CREATE INDEX IF NOT EXISTS idx_person_order_person_id ON person_order(person_id);
CREATE INDEX IF NOT EXISTS idx_person_order_menu_id ON person_order(menu_id);
CREATE INDEX IF NOT EXISTS idx_person_visits_person_id ON person_visits(person_id);
CREATE INDEX IF NOT EXISTS idx_person_visits_pizzeria_id ON person_visits(pizzeria_id);

--DROp INDEX IF EXISTS idx_menu_pizzeria_id;
--DROp INDEX IF EXISTS idx_person_order_person_id;
--DROp INDEX IF EXISTS idx_person_order_menu_id;
--DROp INDEX IF EXISTS idx_person_visits_person_id;
--DROp INDEX IF EXISTS idx_person_visits_pizzeria_id;

--DROP TABLE IF EXISTS menu CASCADE;
--DROP TABLE IF EXISTS person CASCADE;
--DROP TABLE IF EXISTS person_order ;
--DROP TABLE IF EXISTS person_visits  ;
--DROP TABLE IF EXISTS pizzeria  ;
