const {DataTypes, Model} = require('sequelize');
const sequelize = require('../util/database');

class Item extends Model {
}

Item.init({
    // Model attributes are defined here
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    productId: {
        type: DataTypes.INTEGER,
        allowNull: false
        // allowNull defaults to true
    },
    quantity: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    price: {
        type: DataTypes.FLOAT,
        allowNull: false
    },
    total: {
        type: DataTypes.FLOAT,
        allowNull: false
    },
    createdByUserId: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    modifiedByUserId: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    statusId: {
        type: DataTypes.INTEGER,
        allowNull: true
    }
}, {
    createdAt: 'createdDate',
    updatedAt: `modifiedDate`,
    timestamps: true,
    // Other model options go here
    sequelize, // We need to pass the connection instance
    modelName: 'Item' // We need to choose the model name
});

// the defined model is the class itself
console.log(Item === sequelize.models.Product); // true

module.exports = Item;
