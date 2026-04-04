module.exports = {
  createOrder: `
    SELECT core.create_order_with_items(
      $1, $2, $3, $4, $5, $6
    ) AS order_id;
  `,

  markOrderPaid: `
    SELECT core.mark_order_paid_and_update_analytics(
      $1, $2, $3
    );
  `,

  getRecommendations: `
    SELECT * FROM analytics.get_recommended_products_for_customer($1, 20);
  `
};