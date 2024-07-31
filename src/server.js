const Fastify = require("fastify");
const fastify = Fastify({ logger: true });

const PORT = parseInt(process.env.PORT, 10) || 3000;
const HOST = process.env.HOST || "localhost";

fastify.get("/", async (request, reply) => {
  reply
    .code(200)
    .header("Content-Type", "application/json; charset=utf-8")
    .send({ site: "sfeir.dev", article: "build node js app with docker" });
});

fastify.listen({ host: HOST, port: PORT }, (err, address) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
});
