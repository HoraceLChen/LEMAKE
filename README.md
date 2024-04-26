<H1>LeMake</H1>
<p>your friendly AI-powered assistant chef!</p>
![alt text](app/assets/images/LemakeTitleCard.png)
<h2>Project Setup</h2>
<p>
 ⦿ Navigate to desired file directory </br>
 
 ⦿ Clone Repo using "gh repo clone HoraceLChen/LEMAKE" </br>

 ⦿ Open project file using VSCode </br>
 
 ⦿ Install all dependencies with "bundle install" in the terminal </br>
</p>

<h2>APIs and Keys</h2>
<p>
 <strong>NOTE! THIS APPLICATION USES MULTIPLE APIs </strong></br>
 List of API keys required:
 
 ✦ Algolia <br> 
 ✦ Cloudinary <br> 
 ✦ OpenAI <br> 
 ✦ Google API <br> 
 ✦ Google CX <br> 

<h2>Providing API Keys</h2>

 ⦿ In the root project folder of LEMAKE, navigate to the .env file. Create this file if it does not exist </br>

 ⦿ Open the .env file </br>
 
 ⦿ You will need to provide the following keys to ensure full functionality: </br>
 
ALGOLIA_APPLICATION_ID=(YOUR_ID_HERE)</br>
ALGOLIA_API_KEY=(YOUR_KEY_HERE)</br>
CLOUDINARY_URL=(YOUR_URL_HERE)</br>
OPENAI_ACCESS_TOKEN=(YOUR_KEY_HERE)</br>
GOOGLE_API_KEY=(YOUR_KEY_HERE)</br>
GOOGLE_CX_KEY=(YOUR_KEY_HERE)</br>
</p>

<h2>Local Testing</h2>

 ⦿ To run a local test, run command "rails s" in the terminal </br>

 ⦿ Open your webrowser and enter [localhost:3000](http://localhost:3000/) (this address may be different on your device, the local address should be found within the terminal logs </br>
</p>

<h2>Planned improvments</h2>
✦ CI/CD pipeline
✦ Optimisation of ingredients and recipe API call
✦ Add desktop experience

<h2>W.I.P features</h2>
✦ Migrate from Devise to Auth0
✦ Calorie + Nutrient tracker and diet/meal suggestions





