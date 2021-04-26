include: "/views/input_data.view"

view: +input_data {
  derived_table: {
    sql:  SELECT
          (CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', order_items.created_at , 'America/Los_Angeles')) AS DATE)) AS created_date,
          COALESCE(SUM(order_items.sale_price ), 0) AS total_revenue,
          COALESCE(SUM(( order_items.sale_price - inventory_items.cost  ) ), 0) AS total_gross_margin,
          COUNT(DISTINCT CASE WHEN order_items.returned_at IS NOT NULL  THEN order_items.id  ELSE NULL END) AS returned_count,
          COUNT(*) AS order_item_count,
          COALESCE(SUM(CASE WHEN order_items.returned_at IS NOT NULL  THEN order_items.sale_price  ELSE NULL END), 0) AS returned_total_sale_price
          FROM looker-private-demo.ecomm.order_items  AS order_items
          FULL OUTER JOIN looker-private-demo.ecomm.inventory_items  AS inventory_items ON inventory_items.id = order_items.inventory_item_id
          LEFT JOIN looker-private-demo.ecomm.products  AS products ON products.id = inventory_items.product_id
          GROUP BY
              1,
              2,
              3
    ;;
  }
}
