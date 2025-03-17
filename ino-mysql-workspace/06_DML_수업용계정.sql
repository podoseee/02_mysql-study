SHOW VARIABLES LIKE 'autocommit';

use menudb;
DESC tbl_menu;

INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status) VALUES('ino', 2000, 8, 'y'); 