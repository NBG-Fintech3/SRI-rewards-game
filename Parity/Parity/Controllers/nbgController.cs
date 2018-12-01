using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using RestSharp;

namespace Parity.Controllers
{
    [Route("api/[controller]")]
    public class NbgController : Controller
    {
      
        public NbgController()
        {
         
        }
                      

        // GET api/values/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            string[] lines = System.IO.File.ReadAllLines(@"C:\Matlab App\SRI_game\SRI-rewards-game\Parity.txt");
            int NumberOfCustomers = lines.Length / 4;
            string Z = null;
            string response = "";
            for (int i = 0; i < NumberOfCustomers; i++)
            {
                Z += (NumberOfCustomers.ToString() + " " + lines[4 * i] + " " + lines[4 * i + 1] + " " + lines[4 * i + 2] + " " + lines[4 * i + 3] + System.Environment.NewLine);


                Z = "OK";
                var client = new RestClient("https://microsites.nbg.gr/api.gateway/sandbox/loyalty/headers/v1.1/Loyalty/registerCustomer");
                var request = new RestRequest(Method.POST);
                request.AddHeader("sandbox_id", "parity");
                request.AddHeader("application_id", "1B01DE32-485E-4A6F-87CF-3D6A50F09FD1");
                request.AddHeader("user_id", "395ab23c-a973-4d00-965f-6d1d379522c4");
                request.AddHeader("username", "User1");
                request.AddHeader("provider_id", "NBG.gr");
                request.AddHeader("provider", "NBG");
                request.AddHeader("Client-Id", "0E1F3E2E-DC73-495C-869C-50ECF1DB3E38");
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", "{\"header\":" +
                    "{\"ID\":\"" + Guid.NewGuid().ToString() + "\"," +
                    "\"application\":\"F9953CB2-AA65-4974-9821-E9FA4474A254\"," +
                    "\"bank\":\"NBG\"," +
                    "\"hostSession\":null," +
                    "\"channel\":\"Loyalty\"," +
                    "\"customer\":0," +
                    "\"logitude\":0," +
                    "\"latitude\":0," +
                    "\"go4moreMember\":true," +
                    "\"TAN\":null}," +
                    "\"payload\":{\"loyaltySchemaId\":\"5d7d889f-4fac-4159-8096-5b05b03f8448\"," +
                    "\"customerAppIdentity\":\"NewUserAppIdentity\"," +
                    "\"firstname\":\"" + lines[4 * i] + "\"," +
                    "\"surname\":\"" + lines[4 * i + 1] + "\"," +
                    "\"birthdayYear\":\"1996\"," +
                    "\"phoneNumber\":\"2111234567\"," +
                    "\"email\":\"" + lines[4 * i + 2] + "\"," +
                    "\"accounts\":[{\"accountNumber\":\"4799 9999 9999 9999\"," +
                    "\"accountType\":\"Card\",\"expirationDate\":\"2022-02-02\"," +
                    "\"holderName\":\"Konstantinos Kokkinis\"}]}}", ParameterType.RequestBody);
                IRestResponse response1 = client.Execute(request);                              

            }

            var client1 = new RestClient("https://microsites.nbg.gr/api.gateway/sandbox/loyalty/headers/v1.1/Loyalty/pointsCollection");
            var request1 = new RestRequest(Method.POST);  
            request1.AddHeader("Client-Id", "0E1F3E2E-DC73-495C-869C-50ECF1DB3E38");  
            request1.AddHeader("provider", "NBG");
            request1.AddHeader("provider_id", "NBG.gr");
            request1.AddHeader("username", "User1");
            request1.AddHeader("user_id", "395ab23c-a973-4d00-965f-6d1d379522c4");
            request1.AddHeader("application_id", "1B01DE32-485E-4A6F-87CF-3D6A50F09FD1");
            request1.AddHeader("sandbox_id", "parity");
            request1.AddHeader("Content-type", "application/json");
            request1.AddParameter("application/json", "{\"header\":" +
                "{\"ID\":\"" + Guid.NewGuid().ToString() + "\"," +
                "\"application\":\"F9953CB2-AA65-4974-9821-E9FA4474A254\"," +
                "\"bank\":\"NBG\"," +
                "\"hostSession\":null," +
                "\"channel\":\"Loyalty\"," +
                "\"customer\":0," +
                "\"logitude\":0," +
                "\"latitude\":0," +
                "\"go4moreMember\":true," +
                "\"TAN\":\"null\"}," +
                "\"payload\":{\"loyaltySchemaId\":\"5d7d889f-4fac-4159-8096-5b05b03f8448\", " +
                "\"merchantAppId\":null," +
                "\"accountNumber\":\"4799 9999 9999 9999\"," +
                "\"customerAppIdentity\":\"User1\"," +
                "\"eventCode\":\"789123456\"," +
                "\"transactionID\":\"" + Guid.NewGuid().ToString() + "\","+
                "\"terminalID\":\"" + Guid.NewGuid().ToString() + "\"," +
                "\"batchID\":\"" + Guid.NewGuid().ToString() + "\"," +
                "\"transactionAmount\":\"" + lines[3] + "\"," +
                "\"transactionDate\":\"2018-12-02\"," +
                "\"currencyCode\":\"EUR\"," +
                "\"latitude\":37.9837," +
                "\"longtitude\":23.7293}}", ParameterType.RequestBody);
            IRestResponse response2 = client1.Execute(request1);
            response = response2.Content;

            return response;
        }
        
    }
}
