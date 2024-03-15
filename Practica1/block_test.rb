require 'minitest/autorun'
require 'digest'
require_relative 'block'

class BlockTest < Minitest::Test
  def setup
    @transactions = [{from: "Ana García", to: "Juan Pérez", what: "Pago de factura de luz", description: "Factura de julio", qty: 85 },                       {from: "Marcos", to: "María Rodríguez", what: "Compra de libros", description: "Libros de ciencia ficción", qty: 3}]
    
    @previous_block = Block.new(0, [], "0")
    @block = Block.new(0, @transactions, @previous_block.hash)
  end

  def test_initialize
    assert_equal 0, @block.index
    assert_equal @transactions, @block.transactions
    assert_kind_of Integer, @block.randomnumber
    assert_kind_of Time, @block.timestamp
    assert_instance_of Array, @block.transactions
    assert_equal 2, @block.transactions_count
    assert_instance_of Integer, @block.nonce
    assert_instance_of String, @block.hash
  end


  def test_compute_hash_with_proof_of_work
    nonce, hash = @block.compute_hash_with_proof_of_work("00")
    assert hash.start_with?("00")
  end

  def test_next_block
    next_block = Block.next(@block, [{ from: "Luisa Martínez",to: "Carlos Sánchez",what: "Pago del alquiler", description: "Alquiler del mes de marzo", qty: 1200 }])
    assert_equal 1, next_block.index
    assert_equal [{ from: "Luisa Martínez", to: "Carlos Sánchez", what: "Pago del alquiler", description: "Alquiler del mes de marzo", qty: 1200}], next_block.transactions
    assert_equal @block.hash, next_block.previous_hash
  end
end