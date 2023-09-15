# README

<!-- This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->

---

  <p align="center">
    This is a practice take home test to prepare soon-to-be-graduates from the <a href="https://turing.edu/">Turing School for Software & Design</a> for the interview process. Students are asked to spend 8 hours building out an MVP (minimum viable product) based off a short <a href="https://mod4.turing.edu/projects/take_home/take_home_be">prompt</a>. Nearly all choices are left open to interpretation.
  </p>
</div>
<br>

<!-- TABLE OF CONTENTS -->
<h2>Table of Contents</h2>

  <ol>
    <li><a href="#inspiration">Inspiration & Decisions Made</a></li>
    <li><a href="#tech">Technologies</a></li>
    <li><a href="#planning">Planning Process</a></li>
    <li><a href="#testing">Testing</a></li>
    <li><a href="#endpoints">Endpoints</a></li>
    <li><a href="#spin_up">Spin Up Your Own Repo</a></li>
    <li><a href="#contact">Contributor</a></li>
  </ol>

<!-- INSPIRATION -->
<h2 id="inspiration">Inspiration & Decisions Made</h2>

<h3><strong>Inspiration</strong></h3>

Using my knowldge of SQl and Active Record I decided to use th prompt to just create a simple tea subscription service. THe idea of creating some parent tables of the teas, customers and subscriptions was the first step, then I knew I needed to join them somehow to show records related to each customer.

<h3><strong>Descisions</strong></h3>
 
Certain decisions had to be made before moving forward in the project:
- It was determined that only the company would have the ability to create a subscription
- Only the company would choose which teas are designated to which subscription. 
- Users will be able to select the `frequency` of tea delivery: *monthly*, *bi-monthly*, *quartery*, and *yearly*. They will also be able to change the `status` of their specific subscription: *active* or *cancelled*.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Built With -->
<h2 id="tech">Technologies</h2>

![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) 
![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) 
![RSpec](https://img.shields.io/badge/Rspec-13B5EA.svg?style=for-the-badge&logo=Rolls-Royce&logoColor=white)
![ActiveRecord](https://img.shields.io/badge/Active_Record-FFCD00.svg?style=for-the-badge&logo=Ruby-on-Rails&logoColor=black)
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)
![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Git](https://img.shields.io/badge/git-4B0082.svg?style=for-the-badge&logo=git&logoColor=white)


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<h2 id="planning">Planning Process</h2>

<details>
  <summary>Planning MVP Endpoints</summary>
  Important points that came up when planning the MVP endpoints was considering:
    <ul>
      <li> Which controller(s) the different actions would be written in
      <li> Whether cancelling a subscription meant deleting a record or just updating a status 
      <li> Brainstorming other useful endpoints that could be created if time allowed
    </ul>
</details>

<h2 id="testing">Testing</h2>

- Happy path and sad path testing were considered and tested. When a request cannot be completed, an error object is returned.

<details>
  <summary><code>See Error Handling</code></summary>
  <pre>
    <code>
{
  "errors": [
    {
      "status": "404"
      "title": "Invalid Request",
      "detail": "Couldn't find User with 'id'=< id >"
     }
   ]
}
  </code></pre>
</details>

<br>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h2 id="testing">Endpoints</h2>

**Phase 1:**
- Based on a previous work with Frontend teams, only the record's *`id`* for the `POST` and `PATCH` endpoints are returned. 
- It was decided that the imaginary Fronted team would be using functional programming and Typescript; thus, they would hit a different endpoint to gather the needed information after a record was created or updated. All they might need is the *`id`*, which allows for more flexibility in changing where a user is directed after one of these actions.

<details>
  <summary><code>POST "/api/v1/customers/:id/subscriptions"</code></summary>
 
</details>

<details>
  <summary><code>PATCH "/api/v1/customers/:id/subscriptions"</code></summary>
  
</details>

<details>
  <summary><code>GET "/api/v1/customers/:id/subscriptions"</code></summary>
  
</details>

<br>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SPIN UP YOUR OWN REPO-->
<h2 id="spin_up">Spin Up Your Own Repo</h2>

If you'd like to demo this API on your local machine:
1. Ensure you have the prerequisites:
   - Ruby Version 3.2.2
    - Rails Version 7.0.8.x
    - Bundler Version 2.4.9
1. Clone this repo: `git clone git@github.com:JCBeldo/take_home_tea.git`
1. Navigate to the root folder: `cd take_home_tea`
1. Run: `bundle install`
1. Run: `rails db:{create,migrate,seed}`
1. Inspect the `/db/schema.rb` and compare to the 'Schema' section to ensure migration has been done successfully
1. Run: `rails s`
1. Visit http://localhost:3000/api/v1/customers

<p align="right">(<a href="#readme-top">back to top</a>)</p>
