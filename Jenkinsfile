import java.time.LocalDateTime
import groovy.lang.Binding
import hudson.model.Result
import org.jenkinsci.plugins.workflow.support.steps.build.RunWrapper

@NonCPS
String getLogFromRunWrapper(RunWrapper runWrapper, int logLines) {
  runWrapper.getRawBuild().getLog(logLines).join('\n    ')
}

def buildLocalJob(String jobName, def parameters) {
  // do not fail current job immediatly after triggered job fails
  RunWrapper buildResult = build(
    job: jobName,
    parameters: parameters,
    propagate: false,
    wait: true
  )

  // output logs
  echo getLogFromRunWrapper(buildResult, 10000)

  // now fail if needed
  buildJobResult = buildResult.getCurrentResult()
  if (buildJobResult == Result.UNSTABLE.toString()) {
    echo "unstable result when building ${jobName}"
    currentBuild.result = 'UNSTABLE'
  }
  else if (buildJobResult != Result.SUCCESS.toString()) {
    error "unsuccessful result when building ${jobName}: ${buildJobResult}"
  }
}


pipeline {
  agent any
  

  stages {
    stage('CI/CD Pipeline') {
      steps {
        script {
          def jobs = ['xyz-compile', 'xyz-test', 'xyz-package'] // Specify the names of the jobs you want to run

          for (jobName in jobs) {
              parameters = []
              buildLocalJob(jobName,parameters)
          }
        }
      }
    }
  }
}
