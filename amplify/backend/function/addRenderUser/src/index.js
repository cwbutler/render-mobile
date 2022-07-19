/* Amplify Params - DO NOT EDIT
	ENV
	REGION
	AIRTABLE_API_KEY
Amplify Params - DO NOT EDIT */

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    return event.arguments.input;
};
