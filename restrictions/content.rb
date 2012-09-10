
class Content

  attr_reader :restricted, :created_by
  def initialize(options)
    @created_by = options[:created_by]
    @restricted = options[:restricted]
  end

  def visible_to?(identity)
    return true unless self.restricted
    return true if identity && identity.respond_to?(:god) && identity.god
    return (identity && identity.respond_to?(:id) && identity.id == self.created_by)
  end

  def editable_by?(identity)
    return false unless identity
    return true if identity.respond_to?(:god) && identity.god
    return (identity.respond_to?(:id) && identity.id == self.created_by)
  end

end
