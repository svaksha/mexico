# This file is part of the MExiCo gem.
# Copyright (c) 2012 Peter Menke, SFB 673, Universität Bielefeld
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

require 'spec_helper'

describe Mexico::FileSystem::Resource do
  
  # set up an initial corpus representation from the example file
  before(:each) do
    @basepath = File.join(File.dirname(__FILE__), '..','..','assets','GenialDanebenKorpus')
    @xml = File.open(File.join(@basepath,'Corpus.xml'),'rb') { |f| f.read }
    @corpus = Mexico::FileSystem::Corpus.from_xml(@xml, {:path => @basepath})
    @resource = @corpus.resources.first
  end
  
  context 'any resource' do
  
    it 'should provide access to (possibly zero) local files' do
      @resource.should respond_to('local_files')  
    end

    it 'should provide access to (possibly zero) URLs' do
      @resource.should respond_to('urls')  
    end
    
    it 'should return a collection when asked for local files' do
      @resource.local_files.should be_kind_of(Enumerable)
    end

    it 'should return a collection when asked for urls' do
      @resource.urls.should be_kind_of(Enumerable)
    end
    
  end
  
context 'the first example resource' do

  it 'should have one local file' do
    @resource.local_files.count.should eq(1)
    puts "LOCAL FILES"
    puts @resource.local_files
    puts @resource.local_files[0]
    puts @resource.local_files[0].path
    
  end

  context 'its local file' do

    it 'should have some path' do
      @resource.local_files[0].should respond_to(:path)
    end

    it 'should have the correct path value' do
      @resource.local_files[0].path.should eq './resources/video_files/Nullaustauscher.mov'
    end

  end

  it 'should have one url' do
    @resource.urls.count.should eq(1)
  end
  
end

end