@Records = React.createClass
    getInitialState: ->
      records: @props.data
    componentDidMount: ->
      @_recordsTimeout = setInterval =>
          @_loadRecords()
        , 2000
      @_loadRecords()
    componentWillUnmount: ->
      clearInterval(@_recordsTimeout)
      @_recordsRequest?.abort()
    getDefaultProps: ->
      records: []
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @replaceState records: records
    render: ->
      React.DOM.div
        className: 'records'
        React.DOM.h2
          className: 'title'
          'Records'
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Email'
              React.DOM.th null, 'Name'
              React.DOM.th null, 'Username'
              React.DOM.th null, 'Admin?'
              React.DOM.th null, ''
          React.DOM.tbody null,
            console.log(@state.records)
            for record in @state.records
              React.createElement Record, key: record.id, record: record, handleEditRecord: @updateRecord
    _loadRecords: ->
       @_recordsRequest = $.get "/records", (data) =>
         console.log(data)
         @setState(records: data)
