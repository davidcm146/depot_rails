module CountAccessStore
  extend ActiveSupport::Concern

  included do
    before_action :count_access, only: %i[ index ]
  end
  
  private
    def count_access
      session[:counter] ||= 0
      session[:counter] += 1
    end

    def reset_count_access
      session[:counter] = 0
    end

    def get_count_access
      session[:counter] || 0
    end
end