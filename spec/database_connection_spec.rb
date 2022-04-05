require 'database_connection'

describe DatabaseConnection do
  describe '#setup' do
    it 'sets up a connection to the database with PG' do
      expect(PG).to receive(:connect).with(dbname: 'makersbnb_test')

      DatabaseConnection.setup('makersbnb_test')
    end
  end

  describe '#query' do
    it 'executes a query via PG' do
      connection = DatabaseConnection.setup('makersbnb_test')

      expect(connection).to receive(:exec_params).with('SELECT * FROM places;', [])

      DatabaseConnection.query('SELECT * FROM places;')
    end
  end
end