module DocusignHelper
  require "base64"
  require 'net/http'

  def docusign_post_requests(user, document)
    dev_account_id = ENV['DOCUSIGN_DEVELOPER_ACCOUNT_ID']
    response = envelope_request(user, document)
    envelope_id = response.parsed_response["envelopeId"]
    response = HTTParty.post("https://demo.docusign.net/restapi/v2/accounts/#{dev_account_id}/envelopes/#{envelope_id}/views/recipient", headers: headers, body: data_body.to_json)

    response.parsed_response["url"]
  end

  private

  def envelope_request(user, document)
    dev_account_id = ENV['DOCUSIGN_DEVELOPER_ACCOUNT_ID']
    doc = File.open("net.pdf", 'r') { |fp| fp.read }
    @encoded = Base64.encode64(doc)
    create_vars(user, document)
    HTTParty.post("https://demo.docusign.net/restapi/v2/accounts/#{dev_account_id}/envelopes", headers: headers, body: post_data[:body].to_json)
  end

  def headers
    username = ENV['DOCUSIGN_USERNAME']
    password = ENV['DOCUSIGN_PASSWORD']
    integratorkey = ENV['DOCUSIGN_API']
    headers = {
      "Content-Type" => "application/json",
      "Accept" => "application/json",
      'X-DocuSign-Authentication' => %{{
      "Username" : "#{username}",
      "Password" : "#{password}",
      "IntegratorKey" : "#{integratorkey}"
      }}
    }
  end

  def data_body
    data_body = {
        "authenticationMethod": "email",
        "clientUserId": @user_id,
        "email": @user_email,
        "recipientId": @user_id,
        "returnUrl": "http://localhost:3000/success",
        "username": @user_name
    }
  end

  def post_data
    post_data = {
      body:{
      "documents": [
        {
          "documentBase64": @encoded,
          "documentId": "1",
          "fileExtension": @file_extension,
          "name": "#{@document_name}.#{@file_extension}"
        }
      ],
      "emailSubject": @document_name,
      "recipients":{
        "signers": [
          {
            "email": @user_email,
            "name": @user_name,
            "clientUserId": @user_id,
            "recipientId": @user_id,
            "routingOrder": "1",
            "tabs": {
              "dateSignedTabs":[
                {
                  "anchorString": "signer1date",
                  "anchorYOffset": "-6",
                  "fontSize": "Size12",
                  "name": "Date Signed",
                  "recipientId": "1",
                  "tabLabel": "date_signed"
                },
              ],
              "fullNameTabs": [
                {
                  "anchorString": "signer1name",
                  "anchorYOffset": "-6",
                  "fontSize": "Size12",
                  "name": "Full Name",
                  "recipientId": "1",
                  "tabLabel": "Full Name"
                }
              ],
              "signHereTabs": [
                {
                  "anchorString": "signer1sig",
                  "anchorUnits": "mms",
                  "anchorXOffset": "0",
                  "anchorYOffset": "0",
                  "name": "Please sign here",
                  "optional": "false",
                  "recipientId": "1",
                  "scaleValue": 1,
                  "tabLabel": "signer1sig"
                }
              ],

 "numberTabs": [
          {
            "isPaymentAmount": "false",
            "width": 78,
            "maxLength": 4000,
            "tabLabel": "PaymentTab",
            "documentId": "1",
            "pageNumber": "1",
            "xPosition": "106",
            "yPosition": "283"
          }
        ],
        "formulaTabs": [
          {
            "isPaymentAmount": "false",
            "formula": "([PaymentTab]) * 100",
            "roundDecimalPlaces": "0",
            "paymentDetails": {
              "status": "new",
              "currencyCode": "USD",
              "lineItems": [
                {
                  "name": 'null',
                  "description": 'null',
                  "itemCode": 'null',
                  "amountReference": "PaymentTab"
                }
              ],
              "gatewayAccountId": "4f4dc2ac-4ecc-4710-99f1-ed1386db2d58"
            },
            "requireAll": "false",
            "value": "200",
            "width": 42,
            "required": "true",
            "locked": "true",
            "concealValueOnDocument": "false",
            "disableAutoSize": "false",
            "tabLabel": "PaymentReceipt 1ee9bcf7-8abf-4db0-a127-3a33896ec2e8",
            "documentId": "1",
            "pageNumber": "1",
            "xPosition": "0",
            "yPosition": "0",
          }
        ]

            }
          }
        ]
      },
      "status": "sent"
      }
    }
  end

  def create_vars(user, document)
    @api_key = ENV['DOCUSIGN_API']
    @username =  ENV['DOCUSIGN_USERNAME']
    @password = ENV['DOCUSIGN_PASSWORD']
    @account_id = ENV['DOCUSIGN_ACCOUNT_ID']
    @gatway_account_id = ENV['']
    @file_extension = ".pdf"
    @user_id = user.id
    @user_email = user.email
    @user_name = "Bob"
    @recipient_id = "1" #user.try.id
    @document_id = "300" #document.try.id
    @document_name = "Issues" #document.try.title
  end
end
