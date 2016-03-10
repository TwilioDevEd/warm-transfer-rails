$(function(){
  var callStatus;
  var $agent1Btn = $("#agent1-btn");
  var $agent2Btn = $("#agent2-btn");

  var $answerBtn = $("#answer-btn");
  var $dialAgent2Btn = $("#dial-agent2-btn");

  callStatus = $('#call-status');
  $agent1Btn.on('click', { role: 'agent1' }, agentClick);
  $agent2Btn.on('click', { role: 'agent2' }, agentClick);

  function agentClick(e) {
    var role = e.data.role;
    disableConnectButtons(true);
    fetchToken(role);
  }

  function disableConnectButtons(disable) {
    agent1Btn.prop('disabled', disable);
    agent2Btn.prop('disabled', disable);
  }

  function fetchToken(role) {
    $.post('/token/generate/' + role, {}, function(data) {
      connectClient(data.token)
    }, 'json')
  }

  function connectClient(token) {
    Twilio.Device.setup(token);
  }

  function renderConnectedUi() {
    $agent1Btn.addClass('hidden');
    $agent2Btn.addClass('hidden');
    $agent1Btn.addClass('hidden');
    $("#agent2-btn").prop('disabled', disable);
  }

  Twilio.Device.ready(function (device) {
    updateCallStatus("Ready");

    renderConnectedUi();
  });

  /* Report any errors to the call status display */
  Twilio.Device.error(function (error) {
    updateCallStatus("ERROR: " + error.message);
    disableConnectButtons(false);
  });

  /* Callback for when Twilio Client receives a new incoming call */
  Twilio.Device.incoming(function(connection) {
    updateCallStatus("Incoming support call");

    // Set a callback to be executed when the connection is accepted
    connection.accept(function() {
      updateCallStatus("In call with customer");
    });

    // Set a callback on the answer button and enable it
    answerButton.click(function() {
      connection.accept();
    });
    answerButton.prop("disabled", false);
  });

  function updateCallStatus(status) {
    callStatus.text(status);
  }
});
