const express = require('express');
const router = express.Router();
const response = require('./../response');
const Product = require('./../models/product');


// SET STORAGE
// const storage = multer.diskStorage({
//     destination: function (req, file, cb) {
//         cb(null, imageFolderPath)
//     },
//     filename: function (req, file, cb) {
//         cb(null, file.fieldname + '-' + Date.now())
//     },
// })


router.get('/products', (req, res) => {
    Product.findAll().then((products) => {
        res.send('products list...');
    })
})

// get products
router.get('/product/getAll', (req, res) => {
    Product.findAll().then((products) => {
        response.response({
            res: res,
            data: products,
            status: response.SUCCESS,
            message: 'successfully retrieved'
        })
    }).catch((error) => {
        response.response({
            res: res,
            data: null,
            status: response.FAILED,
            message: error.toString()
        })
    })
})

//create product
router.post('/product/create', (req, res) => {
    const product = req.body;
    Product.create({
        productName: product.productName,
        productDetails: product.productDetails,
        productBrand: product.productBrand,
        productBarcode: product.productBarcode,
        createdByUserId: 1,
        modifiedByUserId: 1,
        statusId: 1
    }).then((product) => {
        // console.log('product created successfully');
        response.response({
            res: res,
            data: product,
            status: response.SUCCESS,
            message: 'successful'
        });
    }).catch((error) => {
        response.response({
            res: res,
            data: null,
            status: response.FAILED,
            message: error.toString()
        })
    })
})
// test
// router.post('/product/upload_image', ((req, res) => {
//         const test = req.body;
//         res.send('reached!');
//     }
// ));

// edit product
router.put('/product/edit', (req, res) => {
    const product = req.body;
    Product.findByPk(product.id).then((foundProduct) => {
        foundProduct.productName = product.productName;
        foundProduct.productDetails = product.productDetails;
        foundProduct.productBrand = product.productBrand;
        foundProduct.productBarcode = product.productBarcode;
        foundProduct.price = product.price;
        foundProduct.createdByUserId = 1;
        foundProduct.modifiedByUserId = 1;
        foundProduct.statusId = 1
        foundProduct.save().then(() => {
            response.response({
                res: res,
                data: foundProduct,
                status: response.SUCCESS,
                message: 'successfully edited'
            })
        }).catch((error) => {
            response.response({
                res: res,
                data: null,
                status: response.FAILED,
                message: error.toString()
            })
        });
    }).catch((error) => {
        response.response({
            res: res,
            data: null,
            status: response.FAILED,
            message: error.toString()
        })
    })
})



module.exports = router;
