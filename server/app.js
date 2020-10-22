const app = require('express')();
const port = 8080;
const bodyParser = require('body-parser');
const userRouter = require('./routes/users-route');
const productRouter = require('./routes/products-route');
const multer = require('multer');
const imageFolderPath = '/Users/sanjay/Documents/GitHub/succor_project/server/images';
const sequelize = require('./util/database')

const upload = multer({ dest: imageFolderPath });

sequelize.sync().then(() => {
    console.log('sequelize is syncing');
})

app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({extended: false}))
// const upload = multer({dest: imageFolderPath});
// app.use(upload.single('image'));
app.use(bodyParser.json({limit:'50mb'}));
app.use(bodyParser.urlencoded({extended:true, limit:'50mb'}));

app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader(
        "Access-Control-Allow-Headers",
        "Origin, X-Requested-With, Content-Type, Accept"
    );
    res.setHeader(
        "Access-Control-Allow-Methods",
        "GET, POST, PATCH, PUT, DELETE, OPTIONS"
    );
    next(); //without this like, the execute with stop
});
app.use(multer({dest: imageFolderPath}).single('image'));

app.get('/', (req, res, next) => {
    // user.findAll().then((user) => {
    res.send('Hello World!')
    // })
});
app.post('/upload', (req, res) => {
    // const file = req.body.image;
    // upload.single(file);
    console.log('reached upload route...');
})

app.use(productRouter);
app.use(userRouter);



app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`));
