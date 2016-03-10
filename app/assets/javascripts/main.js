$(function() {
  var currentConnection;
  var $callStatus;
  var $connectAgent1Button = $("#connect-agent1-button");
  var $connectAgent2Button = $("#connect-agent2-button");

  var $answerCallButton = $("#answer-call-button");
  var $hangupCallButton = $("#hangup-call-button");
  var $dialAgent2Button = $("#dial-agent2-button");

  $callStatus = $('#call-status');
  $connectAgent1Button.on('click', { role: 'agent1' }, agentClick);
  $connectAgent2Button.on('click', { role: 'agent2' }, agentClick);
  $hangupCallButton.on('click', hangUp);

  function agentClick(e) {
    var role = e.data.role;
    disableConnectButtons(true);
    fetchToken(role);
  }

  function disableConnectButtons(disable) {
    $connectAgent1Button.prop('disabled', disable);
    $connectAgent2Button.prop('disabled', disable);
  }

  function fetchToken(role) {
    $.post('/' + role + '/token', {}, function(data) {
      connectClient(data.token)
    }, 'json')
  }

  function connectClient(token) {
    Twilio.Device.setup(token);
  }

  function renderConnectedUi(role) {
    $('#connect-agent-row').addClass('hidden');
    $('#connected-agent-row').removeClass('hidden');
    $connectAgent1Button.addClass('hidden');
  }

  Twilio.Device.ready(function (device) {
    updateCallStatus("Ready");
    renderConnectedUi(device._clientName);
  });

  /* Report any errors to the call status display */
  Twilio.Device.error(function (error) {
    updateCallStatus("ERROR: " + error.message);
    disableConnectButtons(false);
  });

  /* Callback for when Twilio Client receives a new incoming call */
  Twilio.Device.incoming(function(connection) {
    currentConnection = connection;
    updateCallStatus("Incoming support call");

    // Set a callback to be executed when the connection is accepted
    connection.accept(function() {
      updateCallStatus("In call with customer");
      $answerCallButton.prop('disabled', true);
      $hangupCallButton.prop('disabled', false);
    });

    // Set a callback on the answer button and enable it
    $answerCallButton.click(function() {
      connection.accept();
    });
    $answerCallButton.prop('disabled', false);
  });

  /* End a call */
  function hangUp() {
    Twilio.Device.disconnectAll();
  }

  function updateCallStatus(status) {
    $callStatus.text(status);
  }
});
