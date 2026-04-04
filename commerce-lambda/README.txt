ecommerce-lambda-backend/
│
├── serverless.yml
├── package.json
├── package-lock.json
├── .env.example
│
├── src/
│   ├── db/
│   │   ├── index.js
│   │   ├── queries.js
│   │   └── analytics.js
│   │
│   ├── handlers/
│   │   ├── createOrder.js
│   │   ├── markOrderPaid.js
│   │   ├── getRecommendations.js
│   │   └── healthCheck.js
│   │
│   ├── utils/
│   │   ├── response.js
│   │   ├── validator.js
│   │   └── logger.js
│   │
│   └── security/
│       └── rls.js
│
└── README.md


mkdir ecommerce-lambda-backend
cd ecommerce-lambda-backend
npm init -y


npm install pg pg-format uuid jsonwebtoken bcryptjs
npm install serverless --save-dev

npm uninstall serverless-dotenv-plugin
npm install serverless-offline --save-dev


DB_HOST=your-aurora-host
DB_USER=postgres
DB_PASSWORD=Password2026!
DB_NAME=bankdb
JWT_SECRET=ReplaceWithStrongSecret


