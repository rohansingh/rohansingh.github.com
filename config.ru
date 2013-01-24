require 'bundler/setup'
require 'sinatra/base'

# The project root directory
$root = ::File.dirname(__FILE__)

class SinatraStaticServer < Sinatra::Base

  before do
    redirect request.url.sub(/rohanradio\.com/, 'www.rohanradio.com'), 301 if request.host =~ /^rohanradio.com/
  end

  get '/optimism' do
    redirect '/blog/2011/07/25/optimism/', 301
  end

  get '/dont-break-the-back-button' do
    redirect '/blog/2011/06/24/', 301
  end

  get '/getting-aspnet-to-play-nice-with-opera-wget' do
    redirect '/blog/2011/03/28/getting-asp-dot-net-to-play-nice-with-opera-and-wget/', 301
  end

  get '/i-dont-even-know-where-to-start-with-this-tor' do
    redirect '/blog/2011/03/24/i-dont-even-know-where-to-start-with-this-torta/', 301
  end

  get '/outlier-is-pretty-awesome' do
    redirect '/blog/2011/03/02/outlier-is-pretty-awesome/', 301
  end

  get '/posting-json-with-jquery' do
    redirect '/blog/2011/02/22/posting-json-with-jquery/', 301
  end

  get '/a-little-trick' do
    redirect '/blog/2011/02/19/a-little-trick/', 301
  end

  get '/4-simple-rules-for-catching-net-exceptions' do
    redirect '/blog/2010/09/13/4-simple-rules-for-catching-net-exceptions/', 301
  end

  get '/html5-database-api-support-in-an-android-webv' do
    redirect '/blog/2010/08/16/html5-database-api-support-in-an-android-webview/', 301
  end

  get '/one-song-on-repeat' do
    redirect '/blog/2010/08/12/one-song-on-repeat/', 301
  end

  get '/disappointing-regex-challenge' do
    redirect '/blog/2010/08/12/disappointing-regex-challenge/', 301
  end

  get '/import-teachpython' do
    redirect '/blog/2010/08/11/import-teachpython/', 301
  end

  get '/aarons-hucklebear' do
    redirect '/blog/2010/07/27/aarons-hucklebear/', 301
  end

  get '/now-that-is-a-sunset' do
    redirect '/blog/2010/07/27/now-that-is-a-sunset/', 301
  end

  get '/laying-on-the-boat-reading-a-book-drinking-a' do
    redirect '/blog/2010/07/26/laying-on-the-boat/', 301
  end

  get '/c-configurationproperty-code-snippet' do
    redirect '/blog/2010/07/21/configuration-property-code-snippet-c-sharp/', 301
  end

  get '/this-parking-is-very-discriminatory' do
    redirect '/blog/2010/07/20/this-parking-is-very-discriminatory/', 301
  end

  get '/browser-compatibility-testing' do
    redirect '/blog/2010/07/19/browser-compatibility-testing/', 301
  end

  get '/jon-stewart-just-went-down-a-few-points' do
    redirect '/blog/2010/07/18/jon-stewart-just-went-down-a-few-points/', 301
  end

  get '/rethinking-the-gas-tax' do
    redirect '/blog/2010/04/22/rethinking-the-gas-tax/', 301
  end

  get '/oops-0' do
    redirect '/blog/2009/01/07/oops/', 301
  end

  get '/goodbye-couch-0' do
    redirect '/blog/2008/10/28/goodbye-couch/', 301
  end

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_sinatra_file('404.html') {"Sorry, I cannot find #{request.path}"}
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(File.dirname(__FILE__), 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i
    File.exist?(file_path) ? send_file(file_path) : missing_file_block.call
  end

end

run SinatraStaticServer
