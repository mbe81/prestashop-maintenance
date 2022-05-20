/*

Cleanup script for Prestashop 1.6 database.
The script takes care of cleaning the following:

- Old carts
- Old connections
- Old guests
- Old page not founds
- Old search statistics

*/

-- carts
delete from ps_cart 
 where id_cart not in (select id_cart from ps_orders)
   and date_add < subdate(curdate(), 365);

delete from ps_cart_product 
 where id_cart not in (select id_cart from ps_cart);

-- connections
delete from ps_connections
 where date_add < subdate(curdate(), 365);

delete from ps_connections_page 
 where id_connections not in (select id_connections from ps_connections);

delete from ps_connections_source
 where id_connections not in (select id_connections from ps_connections);

-- guest
delete from ps_guest 
 where id_guest not in (select id_guest from ps_cart)
   and id_guest not in (select id_guest from ps_connections)
   and id_guest not in (select id_guest from ps_product_comment);

-- pagenotfound
delete from ps_pagenotfound
 where date_add < subdate(curdate(), 365);

-- statsssearch
delete from ps_statssearch
 where date_add < subdate(curdate(), 365);
