should = require 'should'
request = require 'request-json'
client = request.createClient 'http://localhost:3000/'

describe 'Customer', ->

    id_customer = null

    describe 'POST /customer', ->
        customer = null

        before (done) ->
            customer =
                name: 'roli butron'
                email: 'rolib2@gmail.com'
                preferred_barber: 'test'

            done()

        it 'should return OK', (done) ->

            client.post 'customer/', customer, (err, res, body) ->
                (res.statusCode).should.be.exactly 200
                id_customer =  res.body._id
                done()

    describe 'POST /customer', ->
        customer = null

        before (done) ->
            customer =
                name: 'Juan vargas'
                email: 'juangmail.com'
                preferred_barber: 'test test'

            done()

        it 'should return status code 400 email invalid', (done) ->

            client.post 'customer/', customer, (err, res, body) ->
                (res.statusCode).should.be.exactly 400

                done()

    describe 'POST /customer', ->
        customer = null

        before (done) ->
            customer =
                name: 'alex aguilar'
                email: 'rolib2@gmail.com'
                preferred_barber: 'test 2'

            done()

        it 'should return status 400 Email already exists', (done) ->

            client.post 'customer/', customer, (err, res, body) ->
                (res.statusCode).should.be.exactly 400
                done()
