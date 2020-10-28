const path = require('path');
const multer = require('multer');
const response = require('./../response');
const express = require('express');
const router = express.Router();
const fs = require('fs');
const Product = require('./../models/product');
const logger = require('logger').createLogger(); // logs to STDOUT

// const fileFilter = (req, file, cb) => {
//     if (file.mimetype == 'image/jpeg' || file.mimetype == 'image/png') {
//         cb(null, true);
//     } else {
//         cb(null, false);
//     }
// }
//
// const upload = multer({dest: 'server/images/', fileFilter: fileFilter});


const upload = multer({dest: 'server/images/'});


router.post('/upload_image', upload.single("image"), function (req, res) {
    logger.info('Received file', req.file.originalname);
    const productId = req.body.productId;
    const src = fs.createReadStream(req.file.path);
    const dest = fs.createWriteStream('server/images/' + req.file.originalname);
    src.pipe(dest);
    src.on('end', function () {
        fs.unlinkSync(req.file.path);
        Product.findByPk(productId).then((foundProduct) => {
            foundProduct.imageUrl = `server/images/${req.file.originalname.toString()}`;
            logger.info('imageUrl: ', foundProduct.imageUrl);
            logger.info('foundProduct before saving:', foundProduct);
            foundProduct.save().then(() => {
                logger.info('saved url successfully')
                logger.info('foundProduct after saving:', foundProduct)
            }).catch((error) => {
                logger.error('failed to save the url', error.toString());
            })
        }).catch((error) => {
            logger.error('failed to find the product', error.toString());
        })
        response.response({
            res: res,
            data: null,
            status: response.SUCCESS,
            message: `Image "${req.file.originalname}" uploaded successfully!`
        })
    });
    src.on('error', function (err) {
        response.response({
            res: res,
            data: null,
            status: response.FAILED,
            message: 'Failed to upload the image!'
        })
    });

})

module.exports = router;


// // router.use('/uploads', express.static(path.join(__dirname, '/uploads')));
//
// const storage = multer.diskStorage({
//     destination: (req, file, cb) => {
//         cb(null, './uploads');
//     },
//     filename: (req, file, cb) => {
//         console.log(file);
//         cb(null, Date.now() + path.extname(file.originalname));
//     }
// });
// const fileFilter = (req, file, cb) => {
//     if (file.mimetype == 'image/jpeg' || file.mimetype == 'image/png') {
//         cb(null, true);
//     } else {
//         cb(null, false);
//     }
// }
// const upload = multer({storage: storage, fileFilter: fileFilter});
//
// //Upload route
// router.post('/upload_image', upload.single('image'), (req, res, next) => {
//     try {
//         const test = req.body;
//         console.log(test);
//         response.response({
//             res: res,
//             data: null,
//             status: response.SUCCESS,
//             message: 'Image uploaded successfully!'
//         })
//         // return res.status(201).json({
//         //     message: 'File uploded successfully'
//         // });
//     } catch (error) {
//         console.error(error);
//         response.response(({
//             res: res,
//             data: null,
//             status: response.FAILED,
//             message: 'Failed to upload the image!'
//         }))
//     }
// });
//
// const imageFolderPath = '/Users/sanjay/Documents/Test-Code/Flutter-Test/Shopping_app_project/server/images';
// router.use(multer().single('image'));
// router.use('/images', express.static(path.join(__dirname, '/images')));
// const upload = multer({dest: imageFolderPath});
// // upload image
// router.post('/upload_image', (req, res) => {
//     const file = req.body.image;
//     console.log(file);
//     try {
//         upload.single(file);
//     } catch (err) {
//         console.log('upload failed...');
//     }
//     if (!file) {
//         response.response({
//             res: res,
//             data: null,
//             status: response.FAILED,
//             message: 'failed to upload image'
//         })
//     } else {
//         response.response({
//             res: res,
//             data: file,
//             status: response.SUCCESS,
//             message: 'uploaded successfully'
//         })
//     }
//
// })
//
//
//
// const storage = multer.diskStorage({
//     destination: (req, file, cb) => {
//         cb(null, 'server/images');
//     },
//     filename: (req, file, cb) => {
//         console.log(file);
//         cb(null, Date.now() + path.extname(file.originalname));
//     }
// });
// const fileFilter = (req, file, cb) => {
//     if (file.mimetype == 'image/jpeg' || file.mimetype == 'image/png') {
//         cb(null, true);
//     } else {
//         cb(null, false);
//     }
// }
//
// const upload = multer({storage: storage, fileFilter: fileFilter});
//
// const imageFolderPath = '/Users/sanjay/Documents/Test-Code/Flutter-Test/Shopping_app_project/server/images';
// const upload = multer({dest: imageFolderPath, });
// router.post('/upload_image', upload.single('image'), ((req, res) => {
//     const fileName = req.body.fileName;
//     console.log(fileName);
// }))
