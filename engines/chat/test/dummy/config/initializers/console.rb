module Rails
  class Console
    # Using prepend to ensure IRBExtension's methods are called before Rails::Console's methods
    # This allows us to hook into the start method and run pre_init before the console starts
    prepend IRBExtension
  end
end
