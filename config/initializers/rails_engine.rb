class Rails::Engine
  def self.mounted_path
    route = Rails.application.routes.routes.detect do |route|
      route.app == self
    end
    route && (route.path.spec.left.to_s + route.path.spec.right.to_s)
  end
end
