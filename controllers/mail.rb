require 'sinatra'
require 'sidekiq'
require 'redis'
require 'pony'

class Podding < Sinatra::Base
  get "/mail" do
    MailWorker.perform_async params[:msg]
  end
end



$redis = Redis.connect

class MailWorker
  include Sidekiq::Worker

  def perform(mail)
    `say bombe`

    Pony.mail :to => 'paxos2k@gmail.com',
              :from => 'retinasklave@retinacast.de',
              :subject => 'Testmail',
              :body => 'Ignore everything'

  end
end