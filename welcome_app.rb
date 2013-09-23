require 'twilio-ruby'
require 'sinatra'
require 'rack-flash'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
  erb :index
end

post '/submit' do

  @account_sid = "AC9f9bcf2380073817590d261416b71719"
  @auth_token = "0f712b60d3959dc1fbdf9257a478dfcd"

  @client = Twilio::REST::Client.new(@account_sid, @auth_token)

  @account = @client.account
  @messages = @account.sms.messages.create(
    {
      :from => '+19145954152',
      :to => '+19144003994',
      :body => "#{params[:name]}'s installfest went #{params[:answer]}."
    }
  )

  flash[:notice] = "SMS sent: #{@messages}"
  redirect '/'
end
