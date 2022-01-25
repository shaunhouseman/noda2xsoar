#! /bin/zsh
filename=$1
output=$(cat $filename|jq -r '.name')
playbookId=$(uuidgen| awk '{print tolower($0)}')
taskId=$(uuidgen| awk '{print tolower($0)}')
cat <<EOF > output.yml
id: $playbookId
inputs: []
name: $output
outputs: []
starttaskid: "0"
tasks:
  "0":
    id: "0"
    ignoreworker: false
    isautoswitchedtoquietmode: false
    isoversize: false
    note: false
    quietmode: 0
    separatecontext: false
    skipunavailable: false
    task:
      brand: ""
      id: taskId
      iscommand: false
      name: ""
      version: -1
    taskid: taskId
    timertriggers: []
    type: start
    view: |-
      {
        "position": {
          "x": 265,
          "y": 50
        }
      }
EOF

nodes=$(cat $filename| jq -r '.nodes[].uuid') 
i=1
declare -A arr
while IFS= read -r uuid; do
    id=$i
    arr[$uuid]=$id
    ((i=i+1))
done <<< "$nodes"

while IFS= read -r uuid; do
    cat <<EOF >> output.yml
  "${arr[$uuid]}":
    id: "${arr[$uuid]}"
    ignoreworker: false
    isautoswitchedtoquietmode: false
    isoversize: false
EOF
    #get next tasks
    nextTasks=$(cat $filename|jq '.links[] | select(.fromNode.Uuid=="'$uuid'")'|jq -r '.toNode.Uuid')
    if [ ! -z "$nextTasks" ]
    then
        cat <<EOF >> output.yml
    nexttasks:
      '#none#':
EOF
        while IFS= read -r task; do
            cat <<EOF >> output.yml
      - "${arr[$task]}"
EOF
    done <<< "$nextTasks"
    fi
    
    ###### add name
    taskName=$(cat $filename|jq '.nodes[] | select(.uuid=="'$uuid'")'|jq -r '.properties[].text')
    cat <<EOF >> output.yml
    note: false
    quietmode: 0
    separatecontext: false
    skipunavailable: false
    task:
      brand: ""
      id: $uuid
      iscommand: false
      name: $taskName
      type: title
      version: -1
    taskid: $uuid
    timertriggers: []
    type: title
    view: |-
      {
        "position": {
          "x": 265,
          "y": 195
        }
      }
EOF
done <<< "$nodes"

#end of playbook file:
cat <<EOF >> output.yml
version: -1
view: |-
  {
    "linkLabelsPosition": {},
    "paper": {
      "dimensions": {
        "height": 500,
        "width": 810,
        "x": 50,
        "y": 50
      }
    }
  }
EOF
