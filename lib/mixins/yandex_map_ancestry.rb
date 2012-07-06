module YandexMapAncestry
  def self.included(base)
    base.class_eval {
      before_save :build_address_ancestry, :unless => :build_address_ancestry_in_progress
      attr_accessor :build_address_ancestry_in_progress
      private
      
      def build_address_ancestry
        return if not self.address =~ /,/

        @klass              = eval(self.class.name.to_s)
        names               = self.address.split(/,\s*/)
        current_parent      = nil
        self.build_address_ancestry_in_progress = true

        names[0...-1].each do |n|
          current_parent = insert_node(current_parent, @klass.new({:address => n, :kind => :node}))
        end
        
        
        self.parent = current_parent
        self.address = names.last
        save
      end

      private

      def insert_node(p, node)

        ch = (p.nil? ? @klass.roots : p.children)
        
        if cur = ch.find_by_address(node.address) 
          cur 
        else
          node.build_address_ancestry_in_progress = true
          node.parent = p
          node.save(:validate => false)
          node
        end

      end
      
    }
  end
end
