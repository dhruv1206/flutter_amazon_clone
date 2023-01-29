const express = require("express");
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");

const adminRouter = express.Router();

adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, quantity, images, category, price, id } =
      req.body;
    let product = new Product({
      name,
      description,
      quantity,
      images,
      category,
      price,
      id,
    });
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    if (!id) {
      return res.status(400).json({ msg: "No product id specified" });
    }
    const product = await Product.findByIdAndDelete(id);
    if (!product) {
      return res.status(400).json({ msg: "Product not found" });
    }
    res.json({ msg: "Succesfully deleted the product" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    console.log(e.message);
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
