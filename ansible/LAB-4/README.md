# Objective: Organize Ansible playbooks using roles. Create an Ansible role for installing Jenkins, docker, openshift CLI ‘OC’
- First create roles
- then create invnetoryfule
- ansible.cfg
  
- create roles for jenkins

``
ansible-galaxy init roles/jenkins
```
- create  role for docker
```
ansible-galaxy init roles/openshift_cli
```

- create role for oc

```
ansible-galaxy init roles/openshift_cli
```
- the file strcture
.
├── ansible.cfg
├── inventory
├── roles
│   ├── docker
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── README.md
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── jenkins
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── README.md
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   └── openshift_cli
│       ├── defaults
│       │   └── main.yml
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       │   └── main.yml
│       ├── README.md
│       ├── tasks
│       │   └── main.yml
│       ├── tests
│       │   ├── inventory
│       │   └── test.yml
│       └── vars
│           └── main.yml
└── site.yml

