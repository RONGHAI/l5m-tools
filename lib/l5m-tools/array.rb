class Array
    ##
    # This method will return the argument value.
    # = Example
    #   ["svn", "--email", "ronghai@test.com"].option!('--email)' => "ronghai@test.com"
    #   And the list will be ["svn"]
    #   get option index --email index, delete --email, then delete value next to --email
    def option!(opt)
      if i = self.index(opt)         
        return self.delete_at(i) && self.delete_at(i)
      end
    end
end