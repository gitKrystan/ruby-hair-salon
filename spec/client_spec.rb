require "spec_helper"

describe(Client) do
  describe('#initialize') do
    it('returns an object') do
      donald_trump = create_test_client()
      expect(donald_trump.first_name()).to(eq('Donald'))
      expect(donald_trump.last_name()).to(eq('Trump'))
      expect(donald_trump.phone()).to(eq('503-555-0666'))
    end
  end

  describe('#id') do
    it('sets its ID when you save it') do
      test_client = create_test_client()
      test_client.save()
      expect(test_client.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('saves the client to the database') do
      test_client = create_test_client()
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end

  describe('.all') do
    it('returns an empty array at first') do
      expect(Client.all()).to(eq([]))
    end
  end

  describe('.sort_by') do
    it('sorts the clients by a specified column') do
      donald_trump = create_test_client()
      donald_trump.save()
      bernie_sanders = create_second_client()
      bernie_sanders.save()
      expect(Client.sort_by('last_name', 'ASC')).to(eq([bernie_sanders, donald_trump]))
    end
  end

  describe('.find') do
    it('finds a client by their id number') do
      test_client = create_test_client()
      test_client.save()
      expect(Client.find(test_client.id())).to(eq(test_client))
    end
  end

  describe('#update') do
    it('updates a specified attribute of the object') do
      test_client = create_test_client()
      test_client.save()
      test_stylist = create_test_stylist()
      test_stylist.save()
      test_client.update({
        :first_name => 'Schmonald',
        })
      test_client.add_stylist(test_stylist.id())
      updated_client = Client.find(test_client.id())
      expect(updated_client.first_name()).to(eq('Schmonald'))
      expect(updated_client.last_name()).to(eq(test_client.last_name()))
      expect(updated_client.stylist()).to(eq(test_stylist))
    end
  end

  describe('#delete') do
    it('lets you delete a client from the database') do
      test_client = create_test_client()
      test_client.save()
      second_client = create_second_client()
      second_client.save()
      test_client.delete()
      expect(Client.all()).to(eq([second_client]))
    end
  end
end
