const {DataTypes, Model} = require('sequelize');
const sequelize = require('../util/database');

class Order extends Model {
}

Order.init({
    // Model attributes are defined here
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    itemId: {
        type: DataTypes.INTEGER,
        allowNull: false
        // allowNull defaults to true
    },
    userId: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    cartId: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    total: {
        type: DataTypes.INTEGER,
        allowNull: true
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
    modelName: 'Order' // We need to choose the model name
});

// the defined model is the class itself
console.log(Order === sequelize.models.Order); // true

module.exports = Order;
