# encoding: utf-8

require 'pony'

class Podding < Sinatra::Base

  get "/feedback" do
    @page = Page.first(name: "feedback")
    @num_1 = rand(10)
    @num_2 = rand(10)
    @result = @num_1 + @num_2
    slim :feedback
  end

  get "/feedback/fail/:reason" do |reason|
    @page = Page.first(name: "feedback")
    if reason == "captcha"
      @reason = t( 'captcha_fail' )
    else
      @reason = t( 'unknown' )
    end
    slim :feedback_fail
  end

  get "/feedback/success" do
    @page = Page.first(name: "feedback")
    slim :feedback_success
  end

  post '/feedback' do
    # TODO: Properly sanitize input, verify mail address

    # Verify "captcha"
    result = params[:result].to_i
    num_1 = params[:submit].split("+")[0].to_i
    num_2 = params[:submit].split("+")[1].to_i
    redirect '/feedback/fail/captcha' if result != num_1 + num_2

    name = params[:name].strip
    mail_address = params[:mail].strip
    message = params[:message]
    email = "#{ name } (#{ mail_address }) #{ t 'wrote' }: \n #{ message }"
    Pony.mail(
      :name => name,
      :subject => t( 'feedback_from' ) + name,
      :body => email,
      :from => mail_address,
      :reply_to => mail_address,
      :to => 'feedback@domain.com',
      :via => :smtp,
      :via_options => {
        :address        => 'smtp.durrr.com',
        :port           => '25',
        :user_name      => 'hurr@durrr.com',
        :password       => 'p4ssw0rdy0',
        :authentication => :plain # :plain, :login, :cram_md5, no auth by default    
      })
    redirect '/feedback/success'
  end

end

