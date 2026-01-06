require "test_helper"
require "capybara/rails"
require "selenium/webdriver"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver :remote_chrome do |app|
    browser_options = Selenium::WebDriver::Chrome::Options.new
    browser_options.add_argument("--no-sandbox")
    browser_options.add_argument("--disable-dev-shm-usage")
    browser_options.add_argument("--headless=new")

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: ENV.fetch("SELENIUM_REMOTE_URL", "http://chrome:4444/wd/hub"),
      options: browser_options
    )
  end

  driven_by :remote_chrome

  setup do
    if ENV["GITHUB_ACTIONS"] == "true"
      # CI: Rails runs on the runner, Chrome runs in a container.
      # Bind Rails to all interfaces, and have Chrome reach the runner via host gateway.
      Capybara.server_host = "0.0.0.0"
      Capybara.app_host = "http://host.docker.internal:#{Capybara.server_port}"
    else
      # Docker Compose: both services on the same docker network
      Capybara.server_host = "0.0.0.0"
      Capybara.app_host = "http://web:#{Capybara.server_port}"
    end
  end
end
