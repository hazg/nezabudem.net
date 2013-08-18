module YandexMapAncestry
  def self.included(base)

    base.class_eval {

      after_save :build_address_ancestry, :unless => :build_address_ancestry_in_progress
      after_destroy :cache_childrens_count
      attr_accessor :build_address_ancestry_in_progress
      
      def build_address_ancestry
        prepare_to_save
        #if not self.is_root?
        #  self.parent.update_attribute(:childrens_count, self.parent.subtree.where('kind <> "node" AND id <> ' + self.parent.id.to_s).count)
        #end
        return if not self.address =~ /,/
        
        @klass              = eval(self.class.name.to_s)
        names               = self.address.split(/,\s*/)
        current_parent      = nil
        self.build_address_ancestry_in_progress = true
        names[0...-1].each do |n|
          current_parent = insert_node(
            current_parent, 
            @klass.new(
              {
                :address => n, 
                :address_path => n.mb_chars.downcase, 
                :kind => :node
              }))
        end
        
        
        self.parent = current_parent
        self.address_path = names.last.mb_chars.downcase
        self.address = names.last
        save
        self.cache_childrens_count
      end
      
      def cache_childrens_count

        if not @updating_childrens_count
          @updating_childrens_count = true  
          self.path.each do |x|
            x.childrens_count = x.subtree.where('kind <> "node" AND id <> ' + x.id.to_s).count
            
            x.save
          end
        end

      end

      private
      def prepare_to_save
        make_path
      end
      
      def make_path
        self[:address_path] = self[:address].mb_chars.downcase
      end

      def insert_node(p, node)

        ch = (p.nil? ? @klass.roots : p.children)
        
        if cur = ch.find_by_address_path(node.address_path) 
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
