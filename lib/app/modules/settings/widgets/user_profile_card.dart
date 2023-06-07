import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:up_invest_front/app/modules/auth/bloc/auth_bloc.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final authBloc = context.watch<AuthBloc>((bloc) => bloc.stream);
    final currentAuthState = authBloc.state as AuthLoggedIn;
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: colorScheme.tertiary,
            radius: 50,
            backgroundImage: FileImage(currentAuthState.avatar)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            currentAuthState.authUser.displayName,
            style: TextStyle(
                color: colorScheme.onBackground,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600),
          ),
          Text(
            currentAuthState.authUser.email,
            style: TextStyle(
                color: colorScheme.outline,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600),
          ),
        ]),
        const Expanded(child: SizedBox()),
        IconButton(
            onPressed: () {
              Modular.to.pushNamed('/settings/details');
            },
            icon: ImageIcon(
              color: colorScheme.onBackground,
              const AssetImage('assets/icons/short_right.png'),
            ))
      ],
    );
  }
}
