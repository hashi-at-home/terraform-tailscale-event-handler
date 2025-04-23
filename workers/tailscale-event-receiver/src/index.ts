/**
 * Welcome to Cloudflare Workers! This is your first worker.
 *
 * - Run `npm run dev` in your terminal to start a development server
 * - Open a browser tab at http://localhost:8787/ to see your worker in action
 * - Run `npm run deploy` to publish your worker
 *
 * Bind resources to your worker in `wrangler.jsonc`. After adding bindings, a type definition for the
 * `Env` object can be regenerated with `npm run cf-typegen`.
 *
 * Learn more at https://developers.cloudflare.com/workers/
 */

export default {
	async fetch(request, env, ctx): Promise<Response> {
		// If the Tailscale-Webhook-Signature is present, set it to a value, else return
		const verifySig = request.headers.get('Tailscale-Webhook-Signature')
		if (!verifySig) {
			return new Response('Missing Tailscale-Webhook-Signature', { status: 400 });
		}
		if (request.method === "POST") {
			// split the header into timestamp and signature
			const [timestamp, signature] = verifySig.split(',')

			// verify that the webhook payload is recent. It should be from
			// not more than 5 minutes ago
			const now = Date.now()
			const timestampMs = parseInt(timestamp)
			if (now - timestampMs > 5 * 60 * 1000) {
				return new Response('Webhook payload is too old', { status: 400 });
			}

			const b = await request.json()
			for (const e of b) {
				console.log(`Event: ${e.type}: ${e.message}`)
			}

			return new Response('{"message": "Event Received"}', { status: 200 });
		} else {
			return new Response('Hello World!');
		}
	},
} satisfies ExportedHandler<Env>;
