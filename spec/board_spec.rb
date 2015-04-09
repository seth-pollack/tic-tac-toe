require 'spec_helper'

describe Board do
  describe '#init' do
    it 'should create variable sized boards' do
      (1..10).to_a do |size|
        board = Board.new(size)
        expect(board.board.length).to eq(size)
        expect(board.board[0].length).to eq(size)
        expect(board.board.flatten.length).to eq(size**2)
      end
    end
  end
  describe '#place_marker' do
    it 'should place marker on variable sized boards' do
      (1..10).to_a.each do |size|
        board = Board.new(size)
        (1..size**2).to_a.each do |n|
          x, y = board.send :convert_to_cords, n
          expect(board.board[x][y]).to eq(n)
          board.place_marker(:X, n)
          expect(board.board[x][y]).to eq(:X)
        end
      end
    end
    it 'should throw an error on invalid position' do
      board = Board.new(3)
      expect { board.place_marker(:X, 10) }.to raise_error(/10 is an invalid position/)
    end
  end
  describe '#available_places' do
    it 'should return available_places' do
      board = Board.new(3)
      expect(board.available_places).to eq((1..9).to_a)
      board.place_marker(:X, 1)
      board.place_marker(:X, 2)
      board.place_marker(:X, 3)
      expect(board.available_places).to eq((4..9).to_a)
      board.place_marker(:X, 7)
      board.place_marker(:X, 8)
      board.place_marker(:X, 9)
      expect(board.available_places).to eq((4..6).to_a)
    end
  end
  describe '#check_for_win' do
    context '3 x 3 board' do
      context "with 3 horizontal X's in a row" do
        it 'should win' do
          board = Board.new(3)
          board.instance_eval do
            @board = [
              [:X, :X, :X],
              [4, 5, 6],
              [7, 8, 9]
            ]
          end
          expect(board.check_for_win :X).to eq(true)
        end
      end
      context 'with 3 vertical markers in a row' do
        it 'should win' do
          board = Board.new(3)
          board.instance_eval do
            @board = [
              [:X, 2, 3],
              [:X, 5, 6],
              [:X, 8, 9]
            ]
          end
          expect(board.check_for_win :X).to eq(true)
        end
      end
      context 'with 3 right diagonal markers in a row' do
        it 'should win' do
          board = Board.new(3)
          board.instance_eval do
            @board = [
              [1, 2, :X],
              [4, :X, 6],
              [:X, 8, 9]
            ]
          end
          expect(board.check_for_win :X).to eq(true)
        end
      end
      context 'with 3 left diagonal markers in a row' do
        it 'should win' do
          board = Board.new(3)
          board.instance_eval do
            @board = [
              [:X, 2, 3],
              [4, :X, 6],
              [7, 8, :X]
            ]
          end
          expect(board.check_for_win :X).to eq(true)
        end
      end
    end
    context '5 x 5 board' do
      context "with 5 horizontal X's in a row" do
        it 'should win' do
          board = Board.new(5)
          board.instance_eval do
            @board = [
              [:X, :X, :X, :X, :X],
              [6, 7, 8, 9, 10],
              [11, 12, 13, 14, 15],
              [16, 17, 18, 19, 20],
              [21, 22, 23, 24, 25]]
          end
          expect(board.check_for_win :X).to eq(true)
        end
      end
      context 'with 5 vertical markers in a row' do
        it 'should win' do
          board = Board.new(5)
          board.instance_eval do
            @board = [
              [1, 2, :X, 4, 5],
              [6, 7, :X, 9, 10],
              [11, 12, :X, 14, 15],
              [16, 17, :X, 19, 20],
              [21, 22, :X, 24, 25]]
          end
          expect(board.check_for_win :X).to eq(true)
        end
      end
      context 'with 5 right diagonal markers in a row' do
        it 'should win' do
          board = Board.new(5)
          board.instance_eval do
            @board = [
              [1, 2, 3, 4, :X],
              [6, 7, 8, :X, 10],
              [11, 12, :X, 14, 15],
              [16, :X, 18, 19, 20],
              [:X, 22, 23, 24, 25]]
          end
          expect(board.check_for_win :X).to eq(true)
        end
      end
      context 'with 5 left diagonal markers in a row' do
        it 'should win' do
          board = Board.new(5)
          board.instance_eval do
            @board = [
              [:X, 2, 3, 4, 5],
              [6, :X, 8, 9, 10],
              [11, 12, :X, 14, 15],
              [16, 17, 18, :X, 20],
              [21, 22, 23, 24, :X]]
          end
          expect(board.check_for_win :X).to eq(true)
        end
      end
    end
  end
  describe '#to_s' do
    it 'should print 3 x 3 board' do
      board = Board.new(3)
      expect(board.to_s).to match %( 1 |  2 |  3
                                    ---+----+----
                                     4 |  5 |  6
                                    ---+----+----
                                     7 |  8 |  9 )
    end
    it 'should print 5 x 5 board' do
      board = Board.new(5)
      expect(board.to_s).to match %( 1 |  2 |  3 |  4 |  5
                                    ---+----+----+----+----
                                     6 |  7 |  8 |  9 | 10
                                    ---+----+----+----+----
                                    11 | 12 | 13 | 14 | 15
                                    ---+----+----+----+----
                                    16 | 17 | 18 | 19 | 20
                                    ---+----+----+----+----
                                    21 | 22 | 23 | 24 | 25 )
    end
  end
end
