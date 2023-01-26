const express = require("express");
const admin = require("../middlewares/admin");
const {Product} = require("../models/product");

const adminRouter = express.Router();

adminRouter.post("/admin/add-product", admin,async (req, res)=>{
    try {
        const {name, description, quantity, images, category, price, id} = req.body;
        let product = new Product({
            name,
            description, 
            quantity,
            images,
            category, 
            price,
            id
        });
        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
});

adminRouter.get("/admin/get-products", admin,async(req, res)=>{
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (err) {
        res.status(500).json({error:err.message})
    }
});

adminRouter.post("/admin/delete-product", admin, async(req, res) => {
    try {
        const {id} = req.body;
        if(!id){
            return res.status(400).json({msg:"No product id specified"})
        }
        const product = await Product.findByIdAndDelete(id);
        if(!product){
            return res.status(400).json({msg:"Product not found"});
        }
        res.json({msg:"Succesfully deleted the product"});
    } catch (err) {
        res.status(500).json({error:err.message});
    }
});

module.exports = adminRouter;