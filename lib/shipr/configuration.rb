module Shipr
  class Configuration
    # The oauth token to use when sending deploy status updates.
    attr_reader :github_deploy_token

    # The github org to use when authenticating users.
    attr_reader :github_organization

    # The ssh key to include in the deploy worker. Use this to be able to clone
    # private github repos and/or push to heroku.
    attr_accessor :ssh_key

    # The base url where shipr is served.
    attr_accessor :base_url

    # The api token for root access.
    attr_accessor :auth_token

    # The deployment provider to use when deploying.
    attr_accessor :provider

    # The notifier to use for deployment status notifications.
    attr_accessor :notifier

    def github_deploy_token
      ENV['GITHUB_DEPLOY_TOKEN']
    end

    def github_organization
      ENV['GITHUB_ORGANIZATION']
    end

    def ssh_key
      ENV['SSH_KEY']
    end

    def base_url
      ENV['BASE_URL']
    end

    def auth_token
      ENV['AUTH_TOKEN']
    end

    def cookie_secret
      ENV['COOKIE_SECRET']
    end

    def github_hook
      base_url.gsub('://', "://:#{auth_token}@") + '/_github'
    end

    def provider
      @provider ||= Provider::IronWorker.new
    end

    def notifier
      @notifier ||= Notifier::Slack.new ENV['SLACK_ACCOUNT'], ENV['SLACK_TOKEN']
    end
  end
end