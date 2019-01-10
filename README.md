# Base-API

Boilerplate for creating APIs, 
- Basic methos login, signup, change_password and change_info
- JWT authentication
- API versioning
- Uuid for objects
- Rspec testing

## Getting started

- Define your database and relationships
- Create the models
- Define the model methods and relationships
- Create the controllers/enpoints
- Create the serializer
- Test the enpoints

POST `http://localhost:3000/login`
POST `http://localhost:3000/signup`
GET POST `http://localhost:3000/works`

# Create a model

`rails g model Post user:references content: string`

## Creating a endpoint
`rails g controller v1/Posts`
then on `config/routes` 
add 
```
scope module: :v1, constraints: ApiVersion.new('v1', true) do
    ...
    resources :posts
end
```


### Endpoints

Sending on body to `/signup`
```
{ 
	"name":"lucas", 
	"email": "rocali@outlook.com", 
	"password" : "12345678", 
	"password_confirmation":"12345678", 
	"login_type": "Manual"
	
}
```
or on `/login`
```
{ 
  "email": "rocali@outlook.com", 
	"password" : "12345678"
}
```

returns 
```
{
    "id": "a7fc5d7a-a8f3-44e9-96d3-29277e059bad",
    "email": "rocali@outlook.com",
    "auth_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiYTdmYzVkN2EtYThmMy00NGU5LTk2ZDMtMjkyNzdlMDU5YmFkIiwiZXhwIjoxNTQ3MTcyOTQ2fQ.U8cH7j-9-uMuiTJkyXelebDJ3FAnI7NSZRrHQnJAWoE"
}
```

The auth_token is responsible for all calls regarding the user

For examploe calling /posts
with the header
`'Authorization': '...auth_token'`

return the posts of the user, using `current_user.posts`

```
class V1::PostsController < ApplicationController
    
    # GET /posts
    def index

        @posts = current_user.posts
        render :json => @posts

    end
end
```

See example on `app/controllers/v1/authentication_controller` and `app/controllers/v1/users_controller`

### Serializer 

`touch app/serializers/post_serializer.rb `
and then
```
class PostSerializer < ActiveModel::Serializer
    attributes :id, :content
  end
  
```

See example on `app/serializer/user_serializer`

### Test the enpoint

`touch spec/requests/v1/post_spec.rb`
then
```
require "rails_helper"

RSpec.describe "posts API", type: :request do
  let(:posts_size) { 10 }
  let!(:posts) { create_list(:category, posts_size) }
 
  let(:headers) { valid_headers }

  describe "GET /posts" do
    before { get "/posts", params: {}, headers: headers }

    it "returns posts" do
      expect(json).not_to be_empty
      expect(json.size).to eq(posts_size)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  ...
end
```

See the example on `spec/requests/v1/users_spec.rb`

### Active Admin

For active admin
`rails generate active_admin:resource Post`
then add the permitted atributes
```
ActiveAdmin.register Post do

    permit_params :content

end

```
See the example on `app/admin/user.rb`


### DB

`rake db:drop db:create db:migrate db:seed `
`rake db:drop db:create db:migrate db:seed RAILS_ENV=test`