# This file is part of the MExiCo gem.
# Copyright (c) 2012, 2013 Peter Menke, SFB 673, Universität Bielefeld
# http://www.sfb673.org
#
# MExiCo is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# MExiCo is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with MExiCo. If not, see
# <http://www.gnu.org/licenses/>.

# A template class doing nothing.
class Mexico::FileSystem::URL
  
  include Mexico::FileSystem::BoundToCorpus
  extend Mexico::FileSystem::IdRef
  extend Mexico::FileSystem::StaticCollectionRef
  
  include ::ROXML
  
  xml_accessor :identifier,     :from => '@identifier' 
  xml_accessor :name,           :from => '@name' 
  xml_accessor :description,    :from => 'Description' 

  xml_accessor :href, :from => "@href"


  def initialize(opts={})
    # @corpus = corpus
    [:identifier,:name,:description].each do |att|
      send("#{att}=", opts[att]) if opts.has_key?(att)
    end
  end
  
end