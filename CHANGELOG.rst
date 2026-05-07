=============================================
tuxpeople.rancher_kubernetes Release Notes
=============================================

.. contents:: Topics

v0.1.0
======

Release Summary
---------------

Initial release of the ``tuxpeople.rancher_kubernetes`` collection.

New Roles
---------

- ``common`` – Base Linux system configuration (packages, marker directory)
- ``rke2`` – Template role for RKE2 Kubernetes distribution configuration
- ``harbor`` – Template role for Harbor container registry Helm deployment
- ``rancher`` – Template role for Rancher Manager Helm deployment

Bugfixes
--------

Minor Changes
-------------

- Collection structure follows standard Ansible Galaxy layout (galaxy.yml at repository root)
- All roles include Molecule test scenarios
- All roles include complete ``meta/argument_specs.yml``
