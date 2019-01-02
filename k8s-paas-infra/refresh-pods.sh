# based on the "patch deployment" strategy in this comment:
# https://github.com/kubernetes/kubernetes/issues/13488#issuecomment-372532659
# requires jq

# $1 is a valid namespace
function refresh-all-pods() {
  echo
  DEPLOYMENT_LIST=$(kubectl get deployment -n $1  -o json|jq -r .items[].metadata.name)
  echo "Refreshing pods in all Deployments"
  for deployment_name in $DEPLOYMENT_LIST ; do
    TERMINATION_GRACE_PERIOD_SECONDS=$(kubectl -n $1 get deployment "$deployment_name" -o json|jq .spec.template.spec.terminationGracePeriodSeconds)
    if [ "$TERMINATION_GRACE_PERIOD_SECONDS" -eq 30 ]; then
      TERMINATION_GRACE_PERIOD_SECONDS='31'
    else
      TERMINATION_GRACE_PERIOD_SECONDS='30'
    fi
    patch_string="{\"spec\":{\"template\":{\"spec\":{\"terminationGracePeriodSeconds\":$TERMINATION_GRACE_PERIOD_SECONDS}}}}"
    kubectl -n $1 patch deployment $deployment_name -p $patch_string
  done
  echo
}

refresh-all-pods $NAMESPACE