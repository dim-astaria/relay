import config, { port, host } from "./config";
import { HttpService } from "./http";

const http = new HttpService(config);

const run = async () => {
  await http.initialize();

  http.app.listen({ port, host }, async (err, address) => {
    http.app.log.info(`Server listening on ${address}`);
    if (err) {
      http.app.log.error(err);
      process.exit(1);
    }
  });
}

run();
