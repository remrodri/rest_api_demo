should = require 'should'
request = require 'request-json'
client = request.createClient 'http://localhost:3000/'

describe 'Customer', ->

    id_customer = null

    describe 'POST /customer', ->
        customer = null

        before (done) ->
            customer =
                name: 'David'
                email: 'david@gmail.com'
                preferred_barber: 'David'

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
                name: 'Sam'
                email: 'samgmail.com'
                preferred_barber: 'Sam'

            done()

        it 'should return status code 400 email invalid', (done) ->

            client.post 'customer/', customer, (err, res, body) ->
                (res.statusCode).should.be.exactly 400

                done()

    describe 'POST /customer', ->
        customer = null

        before (done) ->
            customer =
                name: 'Nancy'
                email: 'david@gmail.com'
                preferred_barber: 'Nancy'

            done()

        it 'should return status 400 Email already exists', (done) ->

            client.post 'customer/', customer, (err, res, body) ->
                (res.statusCode).should.be.exactly 400
                done()


    describe 'GET /customer/:id', ->
        id = null

        before (done) ->
            id = id_customer
            done()

        it 'should return OK', (done) ->

            client.get 'customer/'+id, {}, (err, res, body) ->
                (res.statusCode).should.be.exactly 200
                done()


    describe 'GET / customer/:id', ->
        id = null

        before (done) ->
            id = '5601dd84be9ec1e0205e61qw'
            done()

        it 'should return customer not found', (done) ->

            client.get 'customer/'+id, {}, (err, res, body) ->
                (res.statusCode).should.be.exactly 404
                done()


    describe 'PUT /customer/:id', ->
        data = null
        before (done) ->
            data =
                preferred_barber: "Dain DDDDDDDDDD"
            done()

        it 'should return OK', (done) ->

            client.put 'customer/'+id_customer, data, (err, res, body) ->
                (res.statusCode).should.be.exactly 200
                done()


    describe 'PUT / customer/:id', ->
        data = null

        before (done) ->
            id_customer = "5601dd84be9ec1e0205e6144"
            data =
                name: "roli roli"
                email: "roliroli@gmail.com"
                preferred_barber: "Dain"
            done()

        it 'should return customer not found', (done) ->

            client.put 'customer/'+id_customer, data, (err, res, body) ->
                (res.statusCode).should.be.exactly 404

                done()
