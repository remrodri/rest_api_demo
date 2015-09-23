customer = require '../models/customer'

validateEmail = (email) ->
    re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
    re.test (email)

thereIsEmail = (email, cb) ->
    criteria =
        email: email

    customer.findOne criteria, (err, _customer_email) ->
        if err
            cb err
        else
            if _customer_email is null
                cb null, false
            else if _customer_email isnt null
                cb null, true
        return

routes = (app) ->

    app.post '/customer', (req, res) ->

        attributes =
            name: req.body.name
            email: req.body.email
            preferred_barber: req.body.preferred_barber

        isValid = validateEmail req.body.email

        if req.body.name isnt "" and req.body.email isnt "" and req.body.preferredBarber isnt ""

            if isValid
                thereIsEmail req.body.email, (err, flag) ->
                    console.log "flag: " + flag
                    if flag is false
                        new_customer = new customer attributes
                        new_customer.save (err, customer) ->
                            if err
                                return res.json err, 500
                            res.json customer
                    else
                        res.status(400).send 'Email already exists'
            else
                res.status(400).send 'Email not valid.'
        else
            res.status(400).send 'The name, email and preferred_barber is required'


    app.get '/customer/:id', (req, res) ->

        criteria =
            _id: req.params.id

        customer.findOne criteria, (err, _customer) ->
            if err
                res.json err, 400
            else
                if _customer is null or _customer is undefined
                    res.status(404).send 'customer not found'
                else
                    res.json _customer


module.exports = routes